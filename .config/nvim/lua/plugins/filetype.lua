local M = {
  "nathom/filetype.nvim",
}

function M.config()
  require("filetype").setup({
    overrides = {
      extensions = {
        tf = "terraform",
        gotmpl = "gotmpl",
      },
      complex = {
        -- ansible
        [".*/tasks/.*%.yml"] = "yaml.ansible",
        [".*/handlers/.*%.yml"] = "yaml.ansible",
        [".*/default/.*%.yml"] = "yaml.ansible",
        -- https://github.com/towolf/vim-helm
        [".*/templates/.*%.yaml"] = "helm",
        [".*/templates/.*%.tpl"] = "helm",
        ["helmfile.yaml"] = "helm",
      },
      shebang = {
        dash = "sh",
      },
    },
  })
end

return M
