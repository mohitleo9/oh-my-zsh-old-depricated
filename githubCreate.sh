githubCreate() {
    echo "initialize this a git"
    git init
    current="$(basename $(pwd))"
    username=`git config github.user`
    token=`git config github.token`
    echo "echo creating a repo $current"
    curl -u "$username:$token" -d '{"name":"'$current'"}' https://api.github.com/user/repos > /dev/null 2>&1

    echo "creating remote .."
    git remote add origin git@github.com:$username/$current.git > /dev/null 2>&1
    echo "now just make the initial commit and push"
}
