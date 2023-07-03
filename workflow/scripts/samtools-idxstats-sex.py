#!/bin/python3.9
import sys

idxstat = snakemake.input[0]

txt=idxstat.split("/")[2]
chrx=0
chry=0

with open(idxstat, 'r') as file:
	for lline in file:
		line = lline.strip().split("\t")
		if (line[0]=="chrX"):
			chrx=int(line[2])
		elif (line[0]=="chrY"):
			chry=int(line[2])

if (chry/(chrx+chry)>0.1):
	with open("snakemake.output[0]","a") as out:
		out.write(txt.split(".")[0]+"\t"+"male")
else:
	with open("snakemake.output[0]","a") as out:
		out.write(txt.split(".")[0]+"\t"+"female")
