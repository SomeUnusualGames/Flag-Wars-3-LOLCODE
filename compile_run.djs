trained

const fs is plz require with 'fs'
const child_process is plz require with 'child_process'

const DIR is 'src'

shh Main entry point
const MAIN is DIR + '/main.lol'

shh Where to join the .lol files
const OUTPUT_PATH is 'main.lol'

shh LOLCODE compiler
const LCI is 'lci'

shh Regex to import files
const INCLUDE_RE is /BTW INCLUDE "(.+)" PLS/s

shh To execute the code right after creating it.
const EXECUTE is false

such addImports much mainContents
    very newContent is []
    much very i as 0 next i smaller mainContents giv length next i more 1
        const line is mainContents levl i ;
        very result is []
        very matchFound is INCLUDE_RE dose exec with line
        rly matchFound not null
            very filename is matchFound levl 1 ;
            very file is fs.readFileSync('src/' + filename, {encoding: 'utf-8'}) giv split('\n')
            very content is plz addImports with file
            newContent is newContent dose concat with content
        but
            newContent dose push with line
        wow
    wow
    amaze newContent
wow

very mainFile is fs.readFileSync('src/main.lol', {encoding: 'utf-8'}) giv split('\n')
very mainContent is plz addImports with mainFile
fs dose writeFileSync with OUTPUT_PATH mainContent.join('\n')

rly EXECUTE
    const path is `${LCI} ${OUTPUT_PATH}`
    child_process dose exec with path much error stdout stderr
        plz console.loge with stdout
        rly error
            plz console.loge with stderr
        wow
    wow&
wow