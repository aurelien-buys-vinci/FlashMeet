package be.aurelien.buys.apiflashmeet.exceptions;

/**
 * UnauthorizedException to handle unauthorized exceptions.
 */
public class UnauthorizedException extends RuntimeException {

  /**
   * Constructor for UnauthorizedException.
   *
   * @param message the message.
   */
  public UnauthorizedException(String message) {
    super(message);
  }

  /**
   * Constructor for UnauthorizedException.
   */
  public UnauthorizedException() {
    super();
  }
}
