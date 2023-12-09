# Kwargs Function Documentation

This document provides a detailed description of the kwargs module.

## Function

### kwargs

Description:
The kwargs function is designed to parse and retrieve the value of a specified key from a list of arguments in the format <key>=<value>. It's particularly useful for scripts that need to handle named arguments.

Usage:

`kwargs <key> <arg1> <arg2> ... <argN>`
* \<key>: The key whose value you want to retrieve.
* \<arg1>, \<arg2>, ..., \<argN>: The list of arguments in the format \<key>=\<value>.

Parameters:
* key: A string representing the key for which the value is sought.
* arg1 ... argN: A sequence of key-value pairs.

Return Value:
* Outputs the value associated with the given key.
* Returns 0 on success, 1 if the key is not found.

Example:

```bash
# Example usage of kwargs function
result=$(kwargs "username" "user=JohnDoe" "email=john@example.com")
echo $result  # Output: JohnDoe
```

Implementation Details:

* The function starts by storing the first argument as the key and then shifts to the next arguments.
* It iterates over the remaining arguments, splitting each argument on the = character.
* If the left side of the split matches the key, it outputs the right side (the value) and exits with a success status.
* If no matching key is found, the function returns an error status.