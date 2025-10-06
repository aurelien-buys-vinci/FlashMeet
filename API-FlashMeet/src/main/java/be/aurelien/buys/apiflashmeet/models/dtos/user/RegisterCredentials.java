package be.aurelien.buys.apiflashmeet.models.dtos.user;

import be.vinci.ipl.cae.demo.models.entities.user.Civility;
import be.vinci.ipl.cae.demo.models.entities.user.Role;
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
  private Civility civility;
  private Role role;
  private String street;
  private String number;
  private String poBox;
  private String municipality;
  private String postalCode;
  private String country;
}
