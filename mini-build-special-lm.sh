#!/bin/bash -x

# set dir of script
BDIR="/home/scorerbuilder/"
            

rm ${BDIR}mini-lm.txt
rm ${BDIR}lm.arpa
rm ${BDIR}lm.binary
rm ${BDIR}scorer

cp ${BDIR}ground-truth.txt ${BDIR}mini-lm.txt
cat ${BDIR}mini-new-sentence.txt>>${BDIR}mini-lm.txt

/home/kenlm/build/bin/lmplz --text ${BDIR}mini-lm.txt --arpa ${BDIR}lm.arpa -o 3 --discount_fallback
/home/kenlm/build/bin/build_binary -v ${BDIR}lm.arpa ${BDIR}lm.binary

/home/v07env/bin/python3 /home/DeepSpeech/data/lm/generate_package.py --alphabet ${BDIR}alphabet.txt --lm ${BDIR}lm.binary --vocab ${BDIR}mini-lm.txt --default_alpha 0.75 --default_beta 1.85 --package ${BDIR}scorer
