package be.aurelien.buys.apiflashmeet.models.dtos.user;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * AuthenticatedUser DTO.
 */
@Data
@NoArgsConstructor
public class AuthenticatedUser {

  private String email;
  private String token;
  private String lastName;
  private String firstName;
  private String role;
}
