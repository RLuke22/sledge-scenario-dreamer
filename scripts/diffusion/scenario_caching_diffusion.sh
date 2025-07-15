#!/bin/bash

module load miniconda/3
conda activate sledge

export PYTHONUNBUFFERED=1
export NUPLAN_DATA_ROOT="$SCRATCH_ROOT/nuplan_dataset"
export NUPLAN_MAPS_ROOT="$SCRATCH_ROOT/nuplan_dataset/maps"
export SLEDGE_EXP_ROOT="$SCRATCH_ROOT/exp"
export SLEDGE_DEVKIT_ROOT="$HOME/sledge-scenario-dreamer"

JOB_NAME=scenario_caching
AUTOENCODER_CHECKPOINT=$SCRATCH_ROOT/final_scenario_dreamer_stuff/sledge/autoencoder/best_model.ckpt
DIFFUSION_CHECKPOINT=$SCRATCH_ROOT/scratch/final_scenario_dreamer_stuff/sledge/dit/checkpoint
DIFFUSION_MODEL=dit_xl_model # [dit_s_model, dit_b_model, dit_l_model, dit_xl_model]
SEED=0

python $SLEDGE_DEVKIT_ROOT/sledge/script/run_diffusion.py \
py_func=scenario_caching \
seed=$SEED \
job_name=$JOB_NAME \
+diffusion=training_dit_model \
diffusion_model=$DIFFUSION_MODEL \
autoencoder_checkpoint=$AUTOENCODER_CHECKPOINT \
diffusion_checkpoint=$DIFFUSION_CHECKPOINT 