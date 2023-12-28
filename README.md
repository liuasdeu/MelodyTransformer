# MelodyTransformer
MELODYTRANSFORMER: IMPROVING LYRIC-TO-MELODY GENERATION BY CONSIDERING MELODIC FEATURES: is a new methodology for lyric-to-melody generation that proposes the MelodyTransformer, which improves the lyric-to-melody generation quality, to solve the following problems: (1) the lack of innovation and coherence in the generation of musical melodies; (2) the lack of aligned L2M training data to learn the lyric and melody feature alignment adequately.
## Data Preprocessing
|------|
| `python gen.py lmd_full lmd_full` |
After this step, the data folder and the lmd_full folder under the data folder will appear.
## Train the melody language model
bash melody_lm.sh
After this step, the lmd_processed folder in the data folder and the music-ckps folder will appear.
## gen.py' generates training data that sometimes violates the formatting standards in ROC settings, modify the data format after gen.py preprocessing.
cd utils
python format_correct.py 
Maj.notes and min.notes appear in the utils folder.
## Use MelodyTransformer to generate melody clips.
python lm_generate_piece.py maj.notes
python lm_generate_piece.py min.notes
This step takes a long time, so we suggest splitting the maj.notes and min.notes files.
## Store the melody piece into the database
python piece_to_database maj_chorus_wc.notes
python piece_to_database maj_verse.notes
python piece_to_database min_chorus_wc.notes
python piece_to_database min_verse.notes
The database folder appears
## Prepare the data
Enter your lyrics and chord progressions in lyric.txt and chord.txt, we have provided data examples in each document.
## L2M - melody generation
python lyrics_to_melody.py
A MIDI file appears with the name of the first lyric of each song.
## melody evaluation
cd evaluation
python cal_similarity.py MelodyTransformer gruth 
python cal_pitch_diversity.py MelodyTransformer gruth
python iois.py MelodyTransformer gruth
MelodyTransformer is the generated midi file of the melody, gruth is the real melody.

