const app = Elm.Main.init({
  node: document.getElementById("elm"),
});

// TODO: Terrible hack, switch to ports. :(
document.addEventListener("click", function(evt) {
  const copyId = evt.target.dataset.clipboardCopy;
  const copyElement = copyId && document.getElementById(copyId);

  if (copyElement) {
    copyElement.select();
    document.execCommand("copy");
  }
});
