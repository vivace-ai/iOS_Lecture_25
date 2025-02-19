//
//  ViewController.swift
//  NoteTakingApp
//
//  Created by 김영희 25-02-18.
//
//  목적: 메모 작성 앱의 메인 화면을 관리하는 뷰 컨트롤러
//  주요 기능:
//  - CoreData를 사용한 메모 저장 및 관리
//  - 테이블뷰를 통한 메모 목록 표시
//  - 메모 작성, 저장, 삭제 기능
//  - 날짜 정보 표시

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {


    var notes: [Note] = []
    
    
    @IBOutlet weak var noteTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // CoreData 컨텍스트 참조 - CoreData와의 상호작용을 위해 필요
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰가 로드된 후 초기 설정 수행
        tableView.dataSource = self
        fetchNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
        tableView.reloadData()
    }

    func fetchNotes(){ // CoreData에서 저장된 모든 메모를 가져오기
        let request: NSFetchRequest<Note> = Note.fetchRequest() // create fetch request for note
        do{
            notes = try context.fetch(request)
        } catch{
            print("Error fetching notes: \(error)")
        }
        
    }
    
    func saveNote(title: String){  // 메모를 CoreData에 저장
        let newNote = Note(context: context) // create a new note object
        newNote.title = title // set the title
        newNote.dateCreated = Date()
        
        do {
            try context.save() // save the new note to core Data
        } catch{
            print("error saving note \(error)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count // return the number of notes to display in the table view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 각 셀에 메모의 제목과 형식화된 날짜를 표시하도록 구성
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")
        
        //retrive the note for the current row
        let note = notes[indexPath.row]
        
        // set the cell text with the note title and formatted date
        cell?.textLabel?.text = note.title
        cell?.detailTextLabel?.text = DateFormatter.localizedString(from: note.dateCreated ?? Date(), dateStyle: .short, timeStyle: .none)
        return cell!
    }
    
    
    @IBAction func saveNotesButtonPressed(_ sender: UIButton) {
        guard let title = noteTextField.text, !title.isEmpty else {return}
        // 사용자가 빈 텍스트를 제출하는 것을 방지
        // save the note to core data
        saveNote(title:  title)
        // fetch the ntoes
        fetchNotes()
        tableView.reloadData()
        
        //clear the textfield after submission
        noteTextField.text = ""
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        // 메모 삭제 처리
        if editingStyle == .delete {
            let noteToDelete = notes [indexPath.row] // get the note to delete
            context.delete(noteToDelete) // remove note from core Data
            notes.remove(at: indexPath.row) // removes note from array
            
            do {
                try context.save() // save context after deletion
                
            } catch{
                print("Error deleting note: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    

}

