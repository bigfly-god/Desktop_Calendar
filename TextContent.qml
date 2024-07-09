import QtQuick
import QtQuick.Controls

TextArea {
    id:text
    anchors.fill: parent
    property url filepath
    property string title: "untitled"
    function updateModified(m :bool){
        textDocument.modified = m
        textDocument.modifiedChanged()
    }


    function isTitle(){
        return filepath.toString() !== "";
    }

    function updateFilepathAndSyncTitle(newFilepath:url){
        if(newFilepath.toString() === "")
            return;
        filepath = newFilepath

        let index = newFilepath.toString().lastIndexOf('/');
        if (index !== -1) {
            text.title = newFilepath.toString().substring(index + 1);
            console.log("title:", text.title)
        }
    }

    function saveFile(newFilepath : url): bool {
        if(newFilepath.toString() === ""){
            textDocument.save()
            if(textDocument.status === TextDocument.WriteError)
                return false;
            updateModified(false)
            return true
        } else {
            textDocument.saveAs(newFilepath)
            console.log("textDocument.status:", textDocument.status)
            if(textDocument.status === TextDocument.WriteError)
                return false;
            updateFilepathAndSyncTitle(newFilepath)
            updateModified(false)
            return true
        }
    }

    function openFile(newFilepath) {
        if (newFilepath.toString() === "") {
            return false;
        } else {
            let file = new QFile(newFilepath.toString());
            if (!file.open(QIODevice.ReadOnly | QIODevice.Text)) {
                console.error("Failed to open file:", file.errorString());
                return false;
            }
            let fileContent = file.readAll();
            file.close();

            // 将文件内容设置到文档中，假设您的文档是通过 text 属性来设置内容
            textDocument.text = QString.fromUtf8(fileContent);

            console.log("File opened successfully:", newFilepath.toString());

            // 更新文件路径和标题
            updateFilepathAndSyncTitle(newFilepath);

            // 标记为未修改状态
            updateModified(false);

            return true;
        }
    }
}
