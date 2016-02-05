package kz.testcenter.gash.exceptions;

public class DAONotFoundException extends DAOException {
    public DAONotFoundException(String message) {
        super(message);
    }

    public DAONotFoundException(String message, int code) {
        super(message, code);
    }

    private static final long serialVersionUID = -3745981406625507285L;
}