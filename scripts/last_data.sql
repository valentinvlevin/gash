select af.id_vpt, af.arm_sign, t.gid_uchzav,
  lo.class_no, lo.id_listotv, lo.itog_ocen,
  lo.ball1+lo.ball2+lo.ball3+lo.ball4 as sumball, lo.ball1, lo.ball2, lo.ball3, lo.ball4,
  lo.ocen1, lo.ocen2, lo.ocen3, lo.ocen4
from listotv lo
  inner join answer_files af on (af.id_file=lo.id_file)
  inner join
  (
    select distinct laf.id_vpt, laf.arm_sign, t.id_test, t.gid_uchzav, t.id_testtype
    from tests t
      inner join answer_files laf on (t.id_file=laf.id_file)
  ) on ()

  inner join
  (
    select laf.id_vpt, laf.arm_sign, llo.class_no, llo.id_listotv, max(llo.id) as last_id
    from listotv llo
      inner join answer_files laf on (laf.id_file=llo.id_file)
    group by laf.id_vpt, laf.arm_sign, llo.class_no, llo.id_listotv
  ) lid on (lid.id_vpt=af.id_vpt) and (lid.arm_sign=af.arm_sign)
    and (lid.class_no=lo.class_no) and (lid.id_listotv=lo.id_listotv)
    and (lo.id=lid.last_id)

  inner join
  (
    select distinct laf.id_file
    from listotv llo
      inner join answer_files laf on (laf.id_file=llo.id_file)
    where llo.is_iden=1 and llo.variant/10=500 and laf.id_file<=127
  ) elo on (elo.id_file=af.id_file)
where lo.is_iden=1
order by af.id_vpt, af.arm_sign, lo.class_no, lo.id_listotv