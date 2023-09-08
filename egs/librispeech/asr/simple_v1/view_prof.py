import pstats
p = pstats.Stats('prof_ctc.out')
p.sort_stats('time').print_stats(100)
# p.sort_stats('cumulative').print_stats(10)
