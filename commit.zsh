#!/bin/zsh


# Error codes

ERR_MISSING_DEPENDENCY=2
ERR_INVALID_EXERCISE_DIRECTORY=3
ERR_GIT_NO_REPO=4
ERR_GIT_UNRELATED_CHANGES=5
ERR_GIT_NO_CHANGES=6
ERR_GIT_COMMIT=7


# Other constants

PROG=$(basename "$0")


# Helper functions

_msg() {
    printf "%s\n" "$1"
}

_err() {
    printf "%s\n" "$1" >&2
}

_die() {
    _err "$1"
    exit ${2:-1}
}

_dry_msg() {
    printf "[dry-run] %s\n" "$1"
}

_verbose() {
    (( OPT_VERBOSE )) && printf "%s\n" "$1"
}

_help() {
    cat <<EOF
Usage:
  $PROG [options] [EXERCISE_DIRECTORY]

Description:
  Commit an Exercism exercise directory with an auto-incremented
  iteration commit message.

Options:
  --dry-run    Show the git commands that would be run, without
               staging or committing anything.
  --help       Show this help message and exit.

Arguments:
  EXERCISE_DIRECTORY
      Path to an Exercism exercise directory.
      Defaults to the current working directory.

Commit format:
  (language/exercise) iteration N
EOF
}


# Options

OPT_DRY_RUN=0
OPT_VERBOSE=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --help)
            _help
            exit 0
            ;;
        --dry-run)
            OPT_DRY_RUN=1
            OPT_VERBOSE=1
            ;;
        --verbose)
            OPT_VERBOSE=1
            ;;
        --)
            shift
            break
            ;;
        -*)
            _die "Unknown option: $1" $ERR_INVOCATION
            ;;
        *)
            break
            ;;
    esac
    shift
done


# Check dependencies

command -v exercism > /dev/null \
    || _die "Exercism is not installed." $ERR_MISSING_DEPENDENCY
command -v git > /dev/null \
    || _die "Git is not installed." $ERR_MISSING_DEPENDENCY


# Ensure Git repo

git rev-parse --is-inside-work-tree &> /dev/null \
    || _die "Not in a Git repository." $ERR_GIT_NO_REPO


# Resolve and validate the directory to be committed

# Exercism itself downloads exercises to paths like this:
# $WORKSPACE/<language-slug>/<exercise-slug>/
#
# So we, too, will expect that structure. An exercise to be committed
# must be located two levels below the Exercism workspace root. The
# first level beneath $WORKSPACE is the name of the language being
# exercised, and the directories beneath that are the exercises them-
# selves.

# Default to `$PWD` if no arg is given. Whatever we receive, convert
# it to an absolute path.
EXERCISE_DIRECTORY="$1"
if [[ -n "$EXERCISE_DIRECTORY" ]]; then
    _verbose "Received arg EXERCISE_DIRECTORY: $EXERCISE_DIRECTORY"
else
    EXERCISE_DIRECTORY="$PWD"
    _verbose "No EXERCISE_DIRECTORY given. Default: $PWD"
fi

EXERCISE_DIRECTORY="${EXERCISE_DIRECTORY:a}"
_verbose "Resolved EXERCISE_DIRECTORY: $EXERCISE_DIRECTORY"

[[ -d "$EXERCISE_DIRECTORY" ]] \
    || _die "${EXERCISE_DIRECTORY} does not exist." $ERR_INVALID_EXERCISE_DIRECTORY

WORKSPACE="$(exercism workspace 2> /dev/null)" \
    || _die "No Exercism workspace found." $ERR_INVALID_EXERCISE_DIRECTORY

LANGUAGE_DIRECTORY="${EXERCISE_DIRECTORY:h}"

if [[ "${LANGUAGE_DIRECTORY:h}" != "$WORKSPACE" ]]; then
    _die "${EXERCISE_DIRECTORY} is not an Exercism exercise." $ERR_INVALID_EXERCISE_DIRECTORY
fi

_verbose ""


# Ensure clean working directory

STAGED_FILES="$(git diff --cached --name-only)"

if [[ -n "$STAGED_FILES" ]]; then
    _err "Changes already staged for commit:"
    _err "$STAGED_FILES"
    _err ""
    _die "Stash or commit those changes first." $ERR_GIT_UNRELATED_CHANGES
fi

git diff --quiet -- "$EXERCISE_DIRECTORY"
HAS_TRACKED_CHANGES=$?

UNTRACKED_FILES="$( \
git ls-files \
--others \
--exclude-standard \
-- "$EXERCISE_DIRECTORY"
)" 

if [[ -n "$UNTRACKED_FILES" ]]; then
    HAS_UNTRACKED_FILES=1
else
    HAS_UNTRACKED_FILES=0
fi

if (( HAS_TRACKED_CHANGES )); then
    _verbose "Tracked changes: yes"
    if (( HAS_UNTRACKED_FILES )); then
        _verbose "Untracked files: yes"
    else
        _verbose "Untracked files: no"
    fi
else
    _verbose "Tracked changes: no"
    if (( HAS_UNTRACKED_FILES )); then
        _verbose "Untracked files: yes"
    else
        _verbose "Untracked files: no"
        _die "Nothing to commit." $ERR_GIT_NO_CHANGES
    fi
fi

_verbose ""


# Construct commit message

EXERCISE="${EXERCISE_DIRECTORY:t}"
LANGUAGE="${LANGUAGE_DIRECTORY:t}"
ID="$LANGUAGE/$EXERCISE"
COMMIT_PREFIX="($ID)"
_verbose "Programming language: $LANGUAGE"
_verbose "Exercise name: $EXERCISE"

PREVIOUS_ITERATION=$( \
    git log --format='%s' -- "$EXERCISE_DIRECTORY" \
    | grep "^${COMMIT_PREFIX}" \
    | grep -oE 'iteration [0-9]+' \
    | awk '{ print $2 }' \
    | sort -n \
    | tail -1
)

if [[ -z "$PREVIOUS_ITERATION" ]]; then
    CURRENT_ITERATION=0
    _verbose "No previous iteration found. Starting at 0."
else
    CURRENT_ITERATION=$(( PREVIOUS_ITERATION + 1 ))
    _verbose "Previous iteration found. Next: $CURRENT_ITERATION"
fi

COMMIT_MESSAGE="${COMMIT_PREFIX} iteration ${CURRENT_ITERATION}"
_verbose ""


# Stage and commit the exercise

_msg "Commit: ${COMMIT_MESSAGE}..."

if (( OPT_DRY_RUN )); then
    _dry_msg "git add $EXERCISE_DIRECTORY"
    _dry_msg "git commit --quiet -m \"${COMMIT_MESSAGE}\""
else
git add "$EXERCISE_DIRECTORY"
git commit --quiet -m "${COMMIT_MESSAGE}" \
    || _die "Commit failed." $ERR_GIT_COMMIT
fi

_msg "Done."
