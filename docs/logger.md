# Logging Functions Documentation

This document provides detailed descriptions of the logging functions available in the logger module. These functions facilitate tracking different levels of messages in shell scripts.
Logger Configuration

The LOGGER variable determines the logging mode. It can be configured to use stdout, syslog, or a specific file.

* stdout: Logs will be displayed on standard output. (default)
* syslog: Logs will be sent to the system's syslog service.
* file:<file_path>: Logs will be written to the specified file.

## Functions
### debug

Description: Logs a message at the DEBUG level.
Usage: debug <message>
Example:

```bash
debug "This is a debug message."
```
### info

Description: Logs a message at the INFO level.
Usage: info <message>
Example:

```bash
info "This is an informational message."
```

### warn

Description: Logs a message at the WARN level.
Usage: warn <message>
Example:

```bash
warn "This is a warning message."
```

### error

Description: Logs a message at the ERROR level.
Usage: error <message>
Example:

```bash
error "This is an error message."
```

### fatal

Description: Logs a message at the FATAL level.
Usage: fatal <message>
Example:

```bash
fatal "This is a fatal message."
```