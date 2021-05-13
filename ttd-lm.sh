#!/bin/bash -x
echo 'params'
echo $1
echo $2
# set dir of script
BDIR="/home/scorerbuilder/"
WDIR="/home/scorerbuilder/work/$1"
SRCTEXT=${WDIR}.txt
TMPTEXT=${WDIR}-temp.txt
SCORER=${WDIR}.scorer
ALPHABET=${BDIR}alphabet_$2.txt
GROUNDTRUTH=${BDIR}ground-truth_$2.txt

cp ${GROUNDTRUTH} ${TMPTEXT}
cat ${SRCTEXT}>>${TMPTEXT}

/home/kenlm/build/bin/lmplz --text ${TMPTEXT} --arpa ${WDIR}lm.arpa -o 3 --discount_fallback
/home/kenlm/build/bin/build_binary -v ${WDIR}lm.arpa ${WDIR}lm.binary

/home/v07env/bin/python3 /home/DeepSpeech/data/lm/generate_package.py --alphabet ${ALPHABET} --lm ${WDIR}lm.binary --vocab ${TMPTEXT} --default_alpha 0.75 --default_beta 1.85 --package ${SCORER}

rm ${TMPTEXT}
rm ${WDIR}lm.arpa
rm ${WDIR}lm.binary
