# Make an auto command to compile the markdown file
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function()
    -- Get the current file name
    local file_name = vim.fn.expand("%:p")

    -- Define the output PDF file name
    local output_pdf = vim.fn.expand("%:r") .. ".pdf"

    -- Compile the markdown file to PDF using pandoc
    -- [ 10:01:33 ] ❮ pandoc 00-Flutter-Firebase-RealTime.md -t beamer -o 00-Flutter-Firebase-RealTime.pdfV
    local command = string.format("pandoc %s -o %s -t beamer", file_name, output_pdf)

    -- Execute the command
    vim.fn.system(command)

    -- Notify the user
    print("Compiled " .. file_name .. " to " .. output_pdf)
  end,
})
