# Make dirs if they dont exist
TRAIN_EXISTS=$(find train -maxdepth 0 -type d)
TEST_EXITS=$(find test -maxdepth 0 -type d)
VALID_EXISTS=$(find valid -maxdepth 0 -type d)

if [ -z "$TRAIN_EXISTS" ]; then
mkdir train
fi
if [ -z "$TEST_EXITS" ]; then
mkdir test
fi

if [ -z "$VALID_EXISTS" ]; then
mkdir valid
fi

# Remove spaces
find bikes/ -name "* *" -type d | rename 's/ /_/g'
find bikes/ -name "* * *" -type f | rename 's/ /_/g'

for x in bikes/*
do
    n=2
    COUNT_DIR=$(ls "$x" | wc -l)
    OUTPUT_DIR="${x:6}"
    mkdir -p valid/$OUTPUT_DIR
    cp `ls -t "$x"/*.jpg | head --lines=$(expr $COUNT_DIR / $n)` train/$OUTPUT_DIR/
    cp `ls -t "$x"/*.jpg | tail --lines=$(expr $COUNT_DIR / $n)` test/$OUTPUT_DIR/
    echo $x
    echo ".."
done


# assert
COUNT_TEST=ls -r test/* | wc -l
COUNT_TRAIN=ls -r train/* | wc -l
COUNT_BIKES=ls -r bikes/* | wc -l
echo "$COUNT_TEST"
echo "$COUNT_TRAIN"
echo "$COUNT_BIKES"