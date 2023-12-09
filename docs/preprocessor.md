# Preprocessing Instructions Documentation

This document provides detailed descriptions of the preprocessing instructions supported by the provided Bash script.

## Preprocessing Instructions

### {%+include:\<file>%}

Description:

This instruction is used to include the contents of another file into the script at the point where the instruction is placed.

Usage:

`{%+include:<file_path>%}`
* \<file_path>: The path to the file to be included.

Example:

```bash
# In your script
{%+include:other_script.sh%}
```

This will include the contents of other_script.sh in the script.

### {%+pack:\<file>%}

Description:

This instruction allows embedding any file, including binary files, directly into the script. It generates a SHA256 hash of the filename, compresses the file, and encodes it in base64 format.
Usage:

`{%+pack:<file_path>%}`
* \<file_path>: The path to the file to be packed.

Example:

```bash
# In your script
{%+pack:image.png%}
```

This will pack image.png into the script.

### {%+use:\<file>%}

Description:

This instruction is used to include a Shokka module into your script.

Usage:

`{%+use:<module>%}`
* \<module>: The name of the Shokka module

Example:

```bash
# In your script
{%+use:logger%}
```

This will include the Shokka Logger module into your script.