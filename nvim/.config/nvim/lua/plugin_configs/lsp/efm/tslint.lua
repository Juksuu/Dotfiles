local tslint = {
    lintCommand = "tslint.sh ./node_modules/.bin/tslint -s $HOME/.config/yarn/global/node_modules/tslint-unix-formatter/lib/ -t unix",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
}

return tslint
