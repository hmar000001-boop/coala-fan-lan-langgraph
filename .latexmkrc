# XeLaTeX is the only supported document engine for this book.
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$bibtex_use = 2;
$out_dir = 'build';
$clean_ext .= ' glg glo gls glsdefs ist acn acr alg xdy';
