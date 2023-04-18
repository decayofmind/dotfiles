local M = {
  "nathom/filetype.nvim",
}

function M.config()
  require("filetype").setup({
    overrides = {
      extensions = {
        tf = "terraform",
        gotmpl = "gotmpl",
        http = "http",
        --[[ TODO: Remove after https://github.com/nathom/filetype.nvim/issues/94 is fixed ]]
        sh = "sh",
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
        ["Dockerfile%..*"] = "dockerfile",
      },
      shebang = {
        dash = "sh",
      },
    },
  })
end

return M
