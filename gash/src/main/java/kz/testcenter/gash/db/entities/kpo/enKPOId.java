package kz.testcenter.gash.db.entities.kpo;

import java.io.Serializable;

public class enKPOId implements Serializable{
    public short getIdSeason() {
        return idSeason;
    }
    public void setIdSeason(short idSeason) {
        this.idSeason = idSeason;
    }
    private short idSeason;

    public short getVariant() {
        return variant;
    }
    public void setVariant(short variant) {
        this.variant = variant;
    }
    private short variant;

    public short getClassNo() {
        return classNo;
    }
    public void setClassNo(short classNo) {
        this.classNo = classNo;
    }
    private short classNo;

    public short getOrd() {
        return ord;
    }
    public void setOrd(short ord) {
        this.ord = ord;
    }
    private short ord;

    @Override
    public int hashCode() {
        return this.idSeason * 10000000
                + this.classNo*100000
                + this.variant*10
                + this.ord;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (obj == null || obj.getClass() != getClass()) return false;

        enKPOId kpo = (enKPOId) obj;

        return kpo.getIdSeason() == this.getIdSeason()
                && kpo.getClassNo() == this.getClassNo()
                && kpo.getVariant() == this.getVariant()
                && kpo.getOrd() == this.getOrd();
    }

    public enKPOId(short idSeason, short classNo, short variant, short ord) {
        this.setIdSeason(idSeason);
        this.setClassNo(classNo);
        this.setVariant(variant);
        this.setOrd(ord);
    }
}
