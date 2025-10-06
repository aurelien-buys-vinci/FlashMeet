package be.aurelien.buys.apiflashmeet.services;

import be.aurelien.buys.apiflashmeet.exceptions.BadRequestException;
import be.aurelien.buys.apiflashmeet.exceptions.ConflictException;
import be.aurelien.buys.apiflashmeet.exceptions.ResourceNotFoundException;
import be.aurelien.buys.apiflashmeet.exceptions.UnauthorizedException;
import be.aurelien.buys.apiflashmeet.models.dtos.user.AuthenticatedUser;
import be.aurelien.buys.apiflashmeet.models.dtos.user.NewPasswordDto;
import be.aurelien.buys.apiflashmeet.models.dtos.user.RegisterCredentials;
import be.aurelien.buys.apiflashmeet.models.entities.user.User;
import be.aurelien.buys.apiflashmeet.repositories.UserRepository;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.annotation.PostConstruct;
import java.util.Date;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/** User service. */
@Service
public class UserService {

  @Value("${JWT_SECRET}")
  private String jwtSecret;

  @Value("${JWT_LIFETIME}")
  private long lifetimeJwt;

  private Algorithm algorithm;

  private final BCryptPasswordEncoder passwordEncoder;
  private final UserRepository userRepository;

  /**
   * Constructor.
   *
   * @param passwordEncoder the password encoder
   * @param userRepository the user repository
   */
  public UserService(
      BCryptPasswordEncoder passwordEncoder,
      UserRepository userRepository) {
    this.passwordEncoder = passwordEncoder;
    this.userRepository = userRepository;
  }

  /** Initialize the algorithm. */
  @PostConstruct
  public void init() {
    algorithm = Algorithm.HMAC256(jwtSecret);
  }

  /**
   * Create a JWT token.
   *
   * @param email the email to included in the claim
   * @return the JWT token
   */
  public AuthenticatedUser createAuthenticatedUser(String email) {
    String token = createJwtToken(email);

    User user = userRepository.findByEmail(email);
    AuthenticatedUser authenticatedUser = new AuthenticatedUser();
    authenticatedUser.setEmail(email);
    authenticatedUser.setToken(token);
    authenticatedUser.setLastName(user.getLastName());
    authenticatedUser.setFirstName(user.getFirstName());
    return authenticatedUser;
  }

  /**
   * Create a JWT token.
   *
   * @param email the email to included in the claim
   * @return the JWT token
   */
  private String createJwtToken(String email) {
    return JWT.create()
        .withIssuer("auth0")
        .withJWTId(UUID.randomUUID().toString())
        .withClaim("email", email)
        .withIssuedAt(new Date())
        .withExpiresAt(new Date(System.currentTimeMillis() + lifetimeJwt))
        .sign(algorithm);
  }

  /**
   * Verify a JWT token.
   *
   * @param token the token to verify
   * @return the email if the token is valid, null otherwise
   */
  public String verifyJwtToken(String token) {
    try {
      return JWT.require(algorithm).build().verify(token).getClaim("email").asString();
    } catch (Exception e) {
      return null;
    }
  }

  /**
   * Login a user.
   *
   * @param email the email
   * @param password the password
   * @return the authenticated user if the login is successful, null otherwise
   */
  public AuthenticatedUser login(String email, String password) {
    User user = userRepository.findByEmail(email);
    if (user == null) {
      throw new ResourceNotFoundException("User not found");
    }
    if (!passwordEncoder.matches(password, user.getPassword())) {
      throw new UnauthorizedException("Invalid password");
    }
    return createAuthenticatedUser(email);
  }

  /**
   * Register a new user.
   *
   * @param credentials the user credentials
   * @return the user if the registration is successful
   * @throws BadRequestException if the role is not C
   * @throws ConflictException if the email already exists
   */
  @Transactional(timeout = 10)
  public User register(RegisterCredentials credentials) {
    User user = userRepository.findByEmail(credentials.getEmail());
    if (user != null) {
      throw new ConflictException("Email already exists");
    }
    return createOne(credentials);
  }

  /**
   * Read a user from its email.
   *
   * @param email the email
   * @return the user if it exists, null otherwise
   */
  public User getOneFromEmail(String email) {
    return userRepository.findByEmail(email);
  }

  /**
   * Create a new user.
   *
   * @param credentials the user credentials
   */
  private User createOne(RegisterCredentials credentials) {

    String hashedPassword = passwordEncoder.encode(credentials.getPassword());

    User user = new User();
    user.setEmail(credentials.getEmail());
    user.setPassword(hashedPassword);
    user.setLastName(credentials.getLastName());
    user.setFirstName(credentials.getFirstName());
    user.setPhoneNumber(credentials.getPhoneNumber());

    userRepository.save(user);
    return user;
  }

  /**
   * Change the password of the authenticated user.
   *
   * @param user the authenticated user
   * @param newPasswordDto the new password DTO containing the old and new passwords
   */
  @Transactional(timeout = 10)
  public void changePassword(User user, NewPasswordDto newPasswordDto) {
    User user1 = getLockUserById(user.getId());

    if (!passwordEncoder.matches(newPasswordDto.getOldPassword(), user1.getPassword())) {
      throw new UnauthorizedException("Invalid password");
    }
    String hashedPassword = passwordEncoder.encode(newPasswordDto.getNewPassword());
    user1.setPassword(hashedPassword);
    userRepository.save(user1);
  }

  /**
   * Get a user by its id.
   *
   * @param id the id
   * @return the user if it exists, null otherwise
   */
  @Transactional(timeout = 10)
  public User getLockUserById(Long id) {
    return userRepository
        .findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("User not found"));
  }
}
