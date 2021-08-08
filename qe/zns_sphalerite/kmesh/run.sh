#!/bin/sh
for input in $(ls zns*in); do
  echo "Running ${input}..."
  pw.x -i ${input} > ${input%.in}.out
done
