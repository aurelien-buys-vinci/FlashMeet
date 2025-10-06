package be.aurelien.buys.apiflashmeet.repositories;

import be.aurelien.buys.apiflashmeet.models.entities.user.User;
import jakarta.persistence.LockModeType;
import java.util.Optional;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.repository.CrudRepository;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

/** User repository. */
@Repository
public interface UserRepository extends CrudRepository<User, Long> {

  /**
   * Find a user by its email.
   *
   * @param email the email
   * @return the user
   */
  User findByEmail(String email);

  /**
   * Find a user by its id.
   *
   * @param id the id
   * @return the user
   */
  @Override
  @NonNull
  @Lock(LockModeType.PESSIMISTIC_WRITE)
  Optional<User> findById(@NonNull Long id);
}
