package be.aurelien.buys.apiflashmeet.models.dtos.user;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * NewPassword DTO.
 * This class is used to transfer the new password and the old password
 * when a user wants to change their password.
 */
@Data
@NoArgsConstructor
public class NewPasswordDto {
  private String oldPassword;
  private String newPassword;
}
