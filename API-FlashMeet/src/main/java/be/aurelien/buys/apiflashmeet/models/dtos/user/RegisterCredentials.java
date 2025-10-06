package be.aurelien.buys.apiflashmeet.models.dtos.user;

import lombok.Data;
import lombok.NoArgsConstructor;

/** RegisterCredentials DTO. */
@Data
@NoArgsConstructor
public class RegisterCredentials {

  private String email;
  private String password;
  private String lastName;
  private String firstName;
  private String phoneNumber;
}
