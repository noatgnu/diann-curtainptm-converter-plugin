# DIA-NN to CurtainPTM Converter


## Installation

**[⬇️ Click here to install in Cauldron](http://localhost:50060/install?repo=https%3A%2F%2Fgithub.com%2Fnoatgnu%2Fdiann-curtainptm-converter-plugin)** _(requires Cauldron to be running)_

> **Repository**: `https://github.com/noatgnu/diann-curtainptm-converter-plugin`

**Manual installation:**

1. Open Cauldron
2. Go to **Plugins** → **Install from Repository**
3. Paste: `https://github.com/noatgnu/diann-curtainptm-converter-plugin`
4. Click **Install**

**ID**: `diann-curtainptm-converter`  
**Version**: 1.0.0  
**Category**: utilities  
**Author**: CauldronGO Team

## Description

Convert DIA-NN PTM differential analysis output to CurtainPTM upload format. Processes modified sequences, maps PTM positions to protein sequences, and generates sequence windows around modification sites.

## Runtime

- **Environments**: `python`

- **Entrypoint**: `convert.py`

## Inputs

| Name | Label | Type | Required | Default | Visibility |
|------|-------|------|----------|---------|------------|
| `pr_file` | PR File (Differential Analysis) | file | Yes | - | Always visible |
| `report_file` | Report File (Optional) | file | No | - | Always visible |
| `modification_type` | Modification Type | text | Yes | UniMod:21 | Always visible |
| `fasta_file` | FASTA File (Optional) | file | No | - | Always visible |
| `localization_score_col` | Localization Score Column | text | No | PTM.Site.Confidence | Always visible |
| `multiple_site` | Process Multiple Sites | boolean | No | false | Always visible |
| `uniprot_columns` | UniProt Data Columns | text | No | accession,id,sequence,protein_name | Always visible |
| `output_filename` | Output Filename | text | No | curtainptm_input.txt | Always visible |
| `output_meta` | Output Metadata File | boolean | No | false | Conditional |
| `sequence_window_size` | Sequence Window Size | number (min: 1, max: 101, step: 2) | No | 21 | Always visible |

### Input Details

#### PR File (Differential Analysis) (`pr_file`)

DIA-NN precursor-level differential analysis file containing Modified.Sequence, Precursor.Id, and Protein.Group columns


#### Report File (Optional) (`report_file`)

DIA-NN report file containing protein sequences and PTM.Site.Confidence scores


#### Modification Type (`modification_type`)

Type of modification to process using UniMod identifier (e.g., UniMod:21 for Phosphorylation, UniMod:1 for Acetylation, UniMod:35 for Oxidation, UniMod:4 for Carbamidomethyl)

- **Placeholder**: `UniMod:21`

#### FASTA File (Optional) (`fasta_file`)

Protein sequence FASTA file. If not provided, sequences will be fetched from UniProt automatically.


#### Localization Score Column (`localization_score_col`)

Column name containing PTM site confidence scores in the report file

- **Placeholder**: `PTM.Site.Confidence`

#### Process Multiple Sites (`multiple_site`)

Enable this to process peptides with multiple modification sites. When enabled, all sites will be reported in semicolon-separated format.


#### UniProt Data Columns (`uniprot_columns`)

Comma-separated list of UniProt columns to retrieve when fetching sequences online

- **Placeholder**: `accession,id,sequence,protein_name`

#### Output Filename (`output_filename`)

Name of the output file (will be created in the output folder)

- **Placeholder**: `curtainptm_input.txt`

#### Output Metadata File (`output_meta`)

Generate an additional metadata file with intensity information from the report file. Only works when a report file is provided.


#### Sequence Window Size (`sequence_window_size`)

Size of the sequence window around modification sites (must be odd number). Default is 21 (10 residues before + modification + 10 after).


## Outputs

| Name | File | Type | Format | Description |
|------|------|------|--------|-------------|
| `converted_file` | `*.txt` | data | tsv | Converted file in CurtainPTM upload format with PTM positions, sequence windows, and protein annotations |

## Requirements

- **Python Version**: >=3.10

### Python Dependencies (External File)

Dependencies are defined in: `requirements.txt`

- `curtainutils>=0.1.24`
- `pandas>=2.0.0`
- `click>=8.0.0`

> **Note**: When you create a custom environment for this plugin, these dependencies will be automatically installed.

## Usage

### Via UI

1. Navigate to **utilities** → **DIA-NN to CurtainPTM Converter**
2. Fill in the required inputs
3. Click **Run Analysis**

### Via Plugin System

```typescript
const jobId = await pluginService.executePlugin('diann-curtainptm-converter', {
  // Add parameters here
});
```
