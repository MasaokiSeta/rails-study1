document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".delete").forEach((a) => {
    a.addEventListener("ajax:success", () => {
      const td = a.parentNode;
      const tr = td.parentNode;
      // tr.style.display = "none";
      tr.style.backgroundColor = "#3e3e3e";
    })
  })
  document.querySelectorAll("td").forEach((td) => {
    td.addEventListener("mousemove", (e) => {
      e.currentTarget.style.backgroundColor = "#eff";
    });
    td.addEventListener("mouseout", (e) => {
      e.currentTarget.style.backgroundColor = "";
    });
  })
})