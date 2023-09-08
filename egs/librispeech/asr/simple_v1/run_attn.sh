#!/usr/bin/env bash

# Copyright 2020 Xiaomi Corporation (Author: Junbo Zhang)
# Apache 2.0

# Example of how to build L and G FST for K2. Most scripts of this example are copied from Kaldi.

set -eou pipefail

stage=6

export CUDA_VISIBLE_DEVICES="0"

if [ $stage -le 5 ]; then
  python3 ./prepare.py --full-libri yes
fi


if [ $stage -le 6 ]; then
    # python3 ./train.py # ctc training
    # python3 -m cProfile -o prof2.out
    nsys profile python3 ./mmi_att_transformer_train.py --use-ali-model=False \
            --ali-model-epoch 2 --num-epochs 1 \
            --max-duration 250 \
            --nhead 2 --bucketing-sampler=True
  #  python3 ./mmi_mbr_train.py

  # Single node, multi-GPU training
  # Adapting to a multi-node scenario should be straightforward.
  # ngpus=2
  # python3 -m torch.distributed.launch --nproc_per_node=$ngpus ./mmi_bigram_train.py --world_size $ngpus
fi

if [ $stage -le 7 ]; then
  # python3 ./decode.py # ctc decoding
  # python3 ./mmi_bigram_decode.py --epoch 2
  python3 ./mmi_att_transformer_decode.py --epoch 5
  #  python3 ./mmi_mbr_decode.py
fi
