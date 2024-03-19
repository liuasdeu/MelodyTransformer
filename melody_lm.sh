#!/usr/bin/bash
export MKL_THREADING_LAYER=GNU
cat data/lmd_matched/lib-maj.notes data/lmd_matched/lib-min.notes > data/lmd_processed/all.notes
shuf data/lmd_processed/all.notes | split -a1 -d -l $(echo "$(wc -l < data/lmd_processed/all.notes) * 0.9 / 1"|bc ) - data/lmd_processed/output
mv data/lmd_processed/output0 data/lmd_processed/train.notes
mv data/lmd_processed/output1 data/lmd_processed/valid.notes
fairseq-preprocess --only-source \
              --task language_modeling \
              --trainpref data/lmd_processed/train.notes  \
              --validpref data/lmd_processed/valid.notes   \
              --destdir data/lmd_processed   \
              --workers 40


mkdir music-ckps
fairseq-train data/lmd_processed/   \
            --arch transformer_lm  \
            --task language_modeling     \
            --decoder-attention-heads 4    \
            --decoder-embed-dim 256  --decoder-input-dim 256    \
            --decoder-output-dim 256  --decoder-layers 4   \
            --update-freq 1  --optimizer adam --adam-betas '(0.9, 0.98)' \
            --adam-eps 1e-6 --clip-norm 0.0  \
            --criterion custom_label_smoothed_cross_entropy \
            --label-smoothing 0.1  --lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 \
            --warmup-updates 4000 --lr 0.0001  --attention-dropout 0.1  \
            --dropout 0.1  --weight-decay 0.01 \
            --save-dir music-ckps-test \
            --batch-size 1  --max-target-positions 1024  --skip-invalid-size-inputs-valid-test \
            --log-interval 10 --patience 20 \
            --no-epoch-checkpoints --best-checkpoint-metric 'ppl' | tee music-ckps/log.txt
