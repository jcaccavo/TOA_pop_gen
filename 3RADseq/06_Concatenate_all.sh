#!/bin/bash
inPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/05_PCRduplicatesFilter"
outPath="/srv/public/users/jcaccavo/11_CCGA_full_seq/02_NovaSeq/01_RADseq/06_Concatenated"

cd $inPath

INDIVs="204 203 199 198 196 195 192 219 218 216 215 213 208 206 231 229 228 226 225 224 223 252 251 248 247 244 241 240 269 268 266 264 260 259 258 285 282 281 280 276 275 272 309 301 298 297 296 295 358 357 354 349 348 339 391 201 200 197 194 193 191 190 217 214 212 211 210 209 207 235 234 233 232 230 254 253 250 249 243 242 238 271 267 265 263 262 261 286 284 283 279 278 277 274 305 304 300 299 293 291 290 353 342 337 335 332 322 399 388"

for INDIV in $INDIVs;do
        cat *${INDIV}_1_PCRfiltered.fastq > ${outPath}/${INDIV}_concat_R1.fastq
	cat *${INDIV}_2_PCRfiltered.fastq > ${outPath}/${INDIV}_concat_R2.fastq
done
