provider ruby {
  probe hash__alloc(const char *, int);
  probe array__alloc(const char *, int);
  probe string__alloc(const char *, int);
  probe function__entry(const char *, const char *, const char *, int);

  probe require__entry(const char *, const char *, int);
  probe require__return(const char *);

  probe load__entry(const char *, const char *, int);
  probe load__return(const char *);

  probe raise(const char *, const char *, int);
  probe object__alloc();

  probe object__create__start(const char *, const char *, int);
  probe object__create__done(const char *, const char *, int);
};
