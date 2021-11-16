if exists('g:loaded_spiffy_foldtext')
  finish
endif
let g:loaded_spiffy_foldtext = 1

scriptencoding utf-8

if has('multi_byte')
  let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }═╡ %4n lines ╞═%l{ }'
else
  let g:SpiffyFoldtext_format = '%c{ }  %<%f{ }=| %4n lines |=%l{ }'
endif
