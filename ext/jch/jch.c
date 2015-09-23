#include <ruby.h>

const double JUMP = (double)(1LL << 31);

int32_t
JumpConsistentHashImpl(uint64_t key, int32_t num_buckets)
{
  int64_t b = -1, j = 0;
  while (j < num_buckets) {
    b = j;
    key = key * 2862933555777941757ULL + 1;
    j = (b + 1) * (JUMP / (double)((key >> 33) + 1));
  }
  return b;
}

static
VALUE
JumpConsistentHash(VALUE t, VALUE v_key, VALUE v_num_buckets)
{
  return INT2NUM(JumpConsistentHashImpl(NUM2ULL(v_key),
                  NUM2UINT(v_num_buckets)));
}

void
Init_jch(void)
{
  VALUE m_jch = rb_define_module("Jch");
  rb_define_method(m_jch, "hash", JumpConsistentHash, 2);
}
