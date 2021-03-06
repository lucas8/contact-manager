#!/usr/bin/gawk -f

function print_user()
{
    out = gensub("{filename}", FILENAME, "g", out)
    if(printuser) {
        print out;
    }
}

BEGIN {
    RS="\n";
    FS="=";
    IGNORECASE=1;

    # Parse the arguments
    if(ARGC < 3) {
        print "Usage : acm get category regex [output]";
        exit;
    }
    category = ARGV[1]; delete ARGV[1];
    regex    = ARGV[2]; delete ARGV[2];
    output   = "{name} <{email}>";
    limit    = 3;
    if(ARGC >= 4 && ARGV[3] != "--") {
        output = ARGV[3]; delete ARGV[3];
        limit  = 4;
    }

    # Input files
    if(ARGC <= limit || ARGV[limit] != "--") {
        print "Usage : acm get category regex [output]";
        exit;
    }
    delete ARGV[limit];

    # Misc
    printuser = 0;
    out = output;
}

NF == 2 {   
    user[$1] = $2;
    split($2, parts, ",");
    for(i in parts) {
        if($1 == category && parts[i] ~ regex) {
            printuser = 1;
        }
    }
    out = gensub("{"$1"}", $2, "g", out)
    next;
}

NF != 0 && "name" in user {
    print_user();
    delete user;
    printuser = 0;
    out = output;
    next;
}

END {
    print_user();
}

