package be.aurelien.buys.apiflashmeet.exceptions;

/** BadRequestException to handle bad request exceptions. */
public class BadRequestException extends RuntimeException {

  /** Constructor for BadRequestException. */
  public BadRequestException() {
    super();
  }

  /**
   * Constructor for BadRequestException.
   *
   * @param message the message.
   */
  public BadRequestException(String message) {
    super(message);
  }
}
