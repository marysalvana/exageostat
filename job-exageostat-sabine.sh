#!/bin/bash

#SBATCH --job-name=ExaGeoStat200-%j
#SBATCH -o output/%j.out
#SBATCH --nodes=1
##SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=40
#SBATCH --time=3-23:00:00

module add intel-oneapi

. ../codes/pkg_config.sh
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64

export STARPU_SCHED=eager               # Only needed with ExaGeoStat

## SYNTHETIC BIVARIATE PARSIMONIOUS

#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/synthetic_dmle_test --ncores=19 --computation=exact --kernel=?:?:?:?:?:? --ikernel=1:1:0.1:0.5:1:0.5 --olb=0.01:0.01:0.01:0.01:0.01:-0.01 --oub=5:5:5:5:5:5 --test --N=8100 --dts=320 --zvecs=1 --verbose --kernel_fun="bivariate_matern_parsimonious" --p=1 --q=1

## SYNTHETIC UNIVARIATE SPACETIME

###srun --hint=nomultithread numactl  --interleave=all  ./build/examples/synthetic_dmle_test --ncores=39 --computation=exact --kernel=?:?:?:?:?:?:0 --ikernel=1:0.03:1:1:0.5:0.5:0 --olb=0.001:0.001:0.001:0.001:0.001:0.01:0.001 --oub=3:3:3:3:1:1:5 --test --N=400 --dts=320 --zvecs=1 --verbose --kernel_fun="univariate_spacetime_matern_stationary" --opt_tol=5 --dim=st --time_slots=10 --log

## SYNTHETIC DIFFERENTIAL OPERATOR

#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/synthetic_dmle_test --ncores=39 --computation=exact --kernel=?:?:?:?:?:0:0:?:0:0:?:0:0 --ikernel=0.001:0.01:2:2:0.9:0:0:0.4:0:0:0.04:0:0 --olb=0.0001:0.0001:1.8:1.8:0:0.00001:0.00001:0.00001:0.00001:0.00001:0.00001:5:5 --oub=0.2:0.2:5:5:1:0.001:0.001:1:0.001:0.001:1:20:20 --test --N=12500 --dts=400 --zvecs=1 --verbose --kernel_fun="bivariate_matern_differential_operator" --dim=earth

srun --hint=nomultithread numactl  --interleave=all  ./build/examples/synthetic_dmle_test --ncores=39 --computation=exact --kernel=0.001:1:2:2:0.9:0:0:1:0:0:1:0:0   --ikernel=0.001:1:1.5:1.5:0.9:0:0:1:0:0:1:0:0 --olb=0.0001:0.0001:1.8:1.8:0.5:0.00001:0.00001:0.00001:0.00001:0.00001:0.00001:5:5 --oub=0.2:0.2:5:5:1:0.001:0.001:1:0.001:0.001:1:20:20 --test --N=80 --dts=400 --zvecs=1 --verbose --kernel_fun="bivariate_matern_differential_operator" --dim=earth #--log



## REAL DATA BIVARIATE PARSIMONIOUS

#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/real_csv_dmle_test --ncores=30 --computation=exact --kernel=?:?:?:1:1:?   --olb=0.0001:0.0001:0.0001:0.01:0.01:-0.01 --oub=5:5:5:5:5:1 --dts=320 --verbose --kernel_fun="bivariate_matern_parsimonious" --obs_dir=./synthetic_ds/Z1_argo_ref_loc1 --obs_dir2=./synthetic_ds/Z2_argo_ref_loc1  --locs_file=./synthetic_ds/LOCS_argo_ref_loc1 --dim=3d  --mspe --predict=100 #--opt_iter=5

## REAL DATA DIFFERENTIAL OPERATOR
#STEP1
#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/real_csv_dmle_test --ncores=39 --computation=exact --kernel=?:?:2:2:?:0:0:?:0:0:?:0:0  --olb=0.0001:0.0001:1.5:1.5:0:-0.0009:-0.0009:0:-0.0009:-0.0009:0:-20:-20 --oub=0.2:0.2:5:5:1:0.0009:0.0009:1:0.0009:0.0009:1:20:20   --dts=320 --verbose --kernel_fun="bivariate_matern_differential_operator" --obs_dir=./synthetic_ds/Z1_argo_ref_loc1  --obs_dir2=./synthetic_ds/Z2_argo_ref_loc1   --locs_file=./synthetic_ds/LOCS_argo_ref_loc1  --dim=3d

#STEP2
#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/real_csv_dmle_test --ncores=39 --computation=exact --kernel=0.03143807:0.00652151:2:2:0.00016212:?:?:0.28639959:?:?:0.01926266:?:?  --olb=0.0001:0.0001:1.5:1.5:0:-0.0009:-0.0009:0:-0.0009:-0.0009:0:-20:-20 --oub=0.2:0.2:5:5:1:0.0009:0.0009:1:0.0009:0.0009:1:20:20   --dts=320 --verbose --kernel_fun="bivariate_matern_differential_operator" --obs_dir=./synthetic_ds/Z1_argo_ref_loc1  --obs_dir2=./synthetic_ds/Z2_argo_ref_loc1   --locs_file=./synthetic_ds/LOCS_argo_ref_loc1  --dim=3d

#FULL
#srun --hint=nomultithread numactl  --interleave=all  ./build/examples/real_csv_dmle_test --ncores=39 --computation=exact --kernel=?:?:2:2:?:?:?:?:?:?:?:0:0  --olb=0.0001:0.0001:1.5:1.5:0:-0.0009:-0.0009:0.0001:-0.0009:-0.0009:0.0001:0:0 --oub=0.5:50:5:5:1:0.0009:0.0009:2:0.0009:0.0009:0.5:20:20   --dts=320 --verbose --kernel_fun="bivariate_matern_differential_operator" --obs_dir=./synthetic_ds/Z1_argo_ref_loc1_training  --obs_dir2=./synthetic_ds/Z2_argo_ref_loc1_training   --locs_file=./synthetic_ds/LOCS_argo_ref_loc1_training  --dim=earth  --mspe --predict=100  --actualZ_file=./synthetic_ds/Z1_argo_ref_loc1_testing  --actualZ_file2=./synthetic_ds/Z2_argo_ref_loc1_testing  --actualZloc_file=./synthetic_ds/LOCS_argo_ref_loc1_testing  #--opt_iter=5


