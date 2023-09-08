#!/usr/bin/env bash

export CUDA_VISIBLE_DEVICES="0"

python3 -m cProfile -o prof_ctc.out \
        ./ctc_train.py
