package be.aurelien.buys.apiflashmeet.exceptions;

/**
 * ConflictException to handle conflict exceptions.
 *
 * <p>ConflictException is thrown when there is a conflict with the current state of the resource.
 */
public class ConflictException extends RuntimeException {
  /** Constructor for ConflictException. */
  public ConflictException() {
    super();
  }

  /**
   * Constructor for ConflictException.
   *
   * @param message the message.
   */
  public ConflictException(String message) {
    super(message);
  }
}
