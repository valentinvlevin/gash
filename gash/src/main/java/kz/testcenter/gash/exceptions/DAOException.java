package kz.testcenter.gash.exceptions;

import javax.ejb.ApplicationException;

@ApplicationException(rollback = true)
public class DAOException extends Exception {
    public DAOException(String message) {
        super(message);
        this.exceptionMessage = new ExceptionMessage(message);
    }

    public DAOException(String message, int code) {
        super(message);
        this.exceptionMessage = new ExceptionMessage(message, code);
    }

    private static final long serialVersionUID = 3160664290701593825L;

    public ExceptionMessage getExceptionMessage() {
        return this.exceptionMessage;
    }
    public void setExceptionMessage(ExceptionMessage exceptionMessage) {
        this.exceptionMessage = exceptionMessage;
    }
    private ExceptionMessage exceptionMessage;
}