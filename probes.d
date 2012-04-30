provider ruby {
  probe function__entry(const char *, const char *, const char *, int);
  probe function__return(const char *, const char *, const char *, int);

  probe require__entry(const char *, const char *, int);
  probe require__return(const char *);

  probe load__entry(const char *, const char *, int);
  probe load__return(const char *);

  probe raise(const char *, const char *, int);

  probe object__create__start(const char *, const char *, int);
  probe object__create__done(const char *, const char *, int);

  probe gc__begin();
  probe gc__end();
  probe gc__mark__begin();
  probe gc__mark__end();
  probe gc__sweep__begin();
  probe gc__sweep__end();

  probe line(const char *, int);
};
