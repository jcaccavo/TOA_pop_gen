import argparse
import gzip
from Bio import SeqIO


parser = argparse.ArgumentParser(description= "e")
parser.add_argument("inFQ", help="input fq file fwd ")
parser.add_argument("outFQ", help="output fq file")

args = parser.parse_args()

if args.inFQ.endswith(".gz"):
	fqReader = gzip.open(args.inFQ)
else:
	fqReader = open(args.inFQ)

myWriter=open(args.outFQ, "w")


for rec in SeqIO.parse(fqReader, "fastq"):
	newRec = rec.reverse_complement()
	newRec.id = rec.id

	#print rec.seq
	#print"\n\n"
	#print newRec.seq
	SeqIO.write(newRec, myWriter, "fastq")



myWriter.close()
fqReader.close()

