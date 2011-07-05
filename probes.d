provider ruby {
  probe hash__alloc(const char *, int);
  probe array__alloc(const char *, int);
  probe string__alloc(const char *, int);
  probe function__entry(const char *, const char *, int, const char *, int);
  probe object__alloc();
};
