package be.aurelien.buys.apiflashmeet.exceptions;

/**
 * ForbiddenException to handle forbidden exceptions.
 *
 * <p>ForbiddenException is thrown when the client does not have access rights to the content.
 */
public class ForbiddenException extends RuntimeException {
  /** Constructor for ForbiddenException. */
  public ForbiddenException() {
    super();
  }

  /**
   * Constructor for ForbiddenException.
   *
   * @param message the message.
   */
  public ForbiddenException(String message) {
    super(message);
  }
}
