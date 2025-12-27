import argparse
from Bio import SeqIO

parser = argparse.ArgumentParser(description="")
parser.add_argument("sam", help="sam file", type=str)
parser.add_argument("insertList", help="", type=str)

args = parser.parse_args()


samIn = open(args.sam)

fragDICT={}

#names = args.sam.strip().split("/")[-1].split("_")

#myName = names[0] + "_" + names[1] + "_mapped_" + args.sam.strip().split("/")[-2]

for line in samIn:
	if not line.startswith("@"):
		splitted = line.strip().split("\t")
		rID = splitted[0]
		rLen = int(splitted[8])
		if rLen < 0:
			rLen = rLen*(-1)
		if rLen<1000: # only get distance shorter than 1000 bp
			if fragDICT.get(rID, "empty") == "empty":
				fragDICT[rID] = rLen
			else:
				if fragDICT[rID] != rLen:
					print "ERROR"
		


myWriter = open(args.insertList, "w")

for key in fragDICT:
	if fragDICT[key] > 0:
		myWriter.write("%i\t%s\n" %(fragDICT[key], key))



myWriter.close()
