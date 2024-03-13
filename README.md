# MelodyTransformer
MELODYTRANSFORMER: IMPROVING LYRIC-TO-MELODY GENERATION BY CONSIDERING MELODIC FEATURES: is a new methodology for lyric-to-melody generation that proposes the MelodyTransformer, which improves the lyric-to-melody generation quality, to solve the following problems: (1) the lack of innovation and coherence in the generation of musical melodies; (2) the lack of aligned L2M training data to learn the lyric and melody feature alignment adequately.

## Environment Setup:
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      pip install -r requirements.txt
    </code>
  </pre>
</div>
The implementation of the innovation proposed in this paper is achieved through the local installation of Fairseq. Therefore, it is recommended to proceed with the local installation of Fairseq.
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      cd fairseq
      pip install --editable ./
    </code>
  </pre>
</div>

## Data Preprocessing
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      python gen.py lmd_full lmd_full
    </code>
  </pre>
</div>

Please prepare your data files, the LMD_full MIDI dataset, and name the dataset as lmd_full. After this step, the "data" folder and the lmd_full folder under the "data" folder will appear.

## Train the melody language model
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      bash melody_lm.sh
    </code>
  </pre>
</div>

After this step, the lmd_processed folder in the "data" folder and the "music-ckps" folder will appear.

## Database Generation

### Modify the data format
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      cd utils
      python format_correct.py 
    </code>
  </pre>
</div>

Maj.notes and min.notes appear in the utils folder.

### Use MelodyTransformer to generate melody clips.
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      python lm_generate_piece.py maj.notes
      python lm_generate_piece.py min.notes
    </code>
  </pre>
</div>

Here, the melodic language model is utilized for generating short melodic fragments. Upon successful execution, the files "maj_chorus.notes", "maj_verse.notes", "min_chorus.notes", and "min_verse.notes" will be generated in the "utils" folder.

### Store the melody piece into the database
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      python piece_to_database maj_chorus_wc.notes
      python piece_to_database maj_verse.notes
      python piece_to_database min_chorus_wc.notes
      python piece_to_database min_verse.notes
    </code>
  </pre>
</div>

We have provided the database files here. You can run the above code to generate your own database files.The database folder appears. 

## Lyric-to-melody

### Prepare the data
Enter your lyrics and chord progressions in lyric.txt and chord.txt, we have provided data examples in each document.

### Lyric-to-melody generation
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      python lyrics_to_melody.py
    </code>
  </pre>
</div>

A MIDI file appears with the name of the first lyric of each song.

## Melody evaluation
<div style="background-color: #f1f1f1; padding: 10px; font-size: 1em;">
  <pre>
    <code>
      cd evaluation
      python cal_similarity.py MelodyTransformer gruth 
      python cal_pitch_diversity.py MelodyTransformer gruth
      python iois.py MelodyTransformer gruth
    </code>
  </pre>
</div>


MelodyTransformer is the generated midi file of the melody, gruth is the real melody.
In the "evaluation" folder, we provide MIDI files generated using the proposed melodic language model in this paper, along with the corresponding real melody files.

