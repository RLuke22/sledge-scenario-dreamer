#!/bin/bash

module load miniconda/3
conda activate sledge

export PYTHONUNBUFFERED=1
export NUPLAN_DATA_ROOT="$SCRATCH_ROOT/nuplan_dataset"
export NUPLAN_MAPS_ROOT="$SCRATCH_ROOT/nuplan_dataset/maps"
export SLEDGE_EXP_ROOT="$SCRATCH_ROOT/exp"
export SLEDGE_DEVKIT_ROOT="$HOME/sledge-scenario-dreamer"

JOB_NAME=feature_caching_nuplan_test
AUTOENCODER_CACHE_PATH=$SCRATCH_ROOT/exp/caches/autoencoder_cache
USE_CACHE_WITHOUT_DATASET=True
SEED=0


for MAP in "filter_pgh_test" "filter_lav_test" "filter_sgp_test" "filter_bos_test" 
do
    python $SLEDGE_DEVKIT_ROOT/sledge/script/run_autoencoder.py \
    py_func=feature_caching \
    seed=$SEED \
    job_name=$JOB_NAME \
    +autoencoder=training_rvae_model \
    scenario_builder=nuplan_test \
    scenario_filter=$MAP \
    cache.autoencoder_cache_path=$AUTOENCODER_CACHE_PATH \
    cache.use_cache_without_dataset=$USE_CACHE_WITHOUT_DATASET \
    callbacks="[]" 
done