package kz.testcenter.gash;

/**
 * Created by user on 17.09.2015.
 */
public class AppContants {
    public static final short ID_SEASON = 5;

    private static final byte CLASS_4_PREDMET_QUESTION_COUNT = 15;
    private static final byte CLASS_9_PREDMET_QUESTION_COUNT = 20;
    private static final byte CLASS_11_PREDMET_QUESTION_COUNT = 20;

    private static final byte CLASS_4_PREDMET_COUNT = 2;
    private static final byte CLASS_9_PREDMET_COUNT = 3;
    private static final byte CLASS_11_PREDMET_COUNT = 4;
    public static final byte MAX_PREDMET_COUNT = 4;

    public static int getPredmetQuestionCount(int classNo) {
        switch (classNo) {
            case  4: return CLASS_4_PREDMET_QUESTION_COUNT;
            case  9: return CLASS_9_PREDMET_QUESTION_COUNT;
            case 11: return CLASS_11_PREDMET_QUESTION_COUNT;
            default: return 0;
        }
    }

    public static int getPredmetCount(int classNo) {
        switch (classNo) {
            case  4: return CLASS_4_PREDMET_COUNT;
            case  9: return CLASS_9_PREDMET_COUNT;
            case 11: return CLASS_11_PREDMET_COUNT;
            default: return 0;
        }
    }

    public static short getOcen(int classNo, int ball) {
        final byte ocenCount = 3;
        final byte[][] class4BallOcen =  {{8,3}, {12,4}, {14,5}};
        final byte[][] class9BallOcen = {{10,3}, {15,4}, {18,5}};
        final byte[][] class11BallOcen = {{10,3}, {15,4}, {18,5}};

        byte[][] ballOcen = null;

        switch (classNo) {
            case  4: ballOcen = class4BallOcen; break;
            case  9: ballOcen = class9BallOcen; break;
            case 11: ballOcen = class11BallOcen; break;
        }

        short result = 2;
        for (int i = 0; i<ocenCount; i++)
            if (ball >= ballOcen[i][0])
                result = ballOcen[i][1];
            else
                break;

        return result;
    }

    public static short getItogOcen(int classNo, int ball) {
        final byte ocenCount = 3;
        final byte[][] class4BallOcen =  {{15,3}, {23,4}, {27,5}};
        final byte[][] class9BallOcen = {{30,3}, {45,4}, {54,5}};
        final byte[][] class11BallOcen = {{40,3}, {60,4}, {72,5}};

        byte[][] ballOcen = null;

        switch (classNo) {
            case  4: ballOcen = class4BallOcen; break;
            case  9: ballOcen = class9BallOcen; break;
            case 11: ballOcen = class11BallOcen; break;
        }

        short result = 2;
        for (int i = 0; i<ocenCount; i++)
            if (ball >= ballOcen[i][0])
                result = ballOcen[i][1];
            else
                break;

        return result;
    }
}
