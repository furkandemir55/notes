don't abuse your containers. But if you want to, use

    CMD["sleep", "infinity"]

or 

    ENTRYPOINT ["tail", "-f", "/dev/null"]
