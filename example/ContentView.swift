//
//  ContentView.swift
//  example
//
//  Created by Ethan Morgan on 29/02/2024.
//

import SwiftUI

enum TodoStatus: String {
    case pending
    case done
}

struct Todo: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let status: TodoStatus
}

struct StatusIndicator: View {
    var status: TodoStatus

    var body: some View {
        
        let backgroundColor: Color = {
            switch status {
            case .done:
                return Color.green
            case .pending:
                return Color.orange
            }
        }()

        Text(status == .done ? "Done" : "Pending")
            .font(.footnote)
            .foregroundColor(.white)
            .padding(8)
            .background(backgroundColor)
            .clipShape(Capsule())
        
    }
}

struct AddTodoForm: View {
    @State private var todoTitle: String = ""
    @State private var contentView = ContentView()
    
    private func addTodo() {
        contentView.todos.append(Todo(title: todoTitle, status: .pending))
    }
    
    var body: some View {
        Form {
            TextField("New Todo", text: $todoTitle)
            Button(action: addTodo) {
                Text("Add")
            }
        }
    }
}

struct ContentView: View {
    @State private var todoTitle: String = ""
    @State var todos: [Todo] = [
        Todo(title: "Buy groceries", status: .pending),
        Todo(title: "Finish homework", status: .pending),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List(todos) { todo in
                Text(todo.title)
                    .font(.title)
                StatusIndicator(status: todo.status)
            }
//            AddTodoForm()
            
            TextField("New Todo", text: $todoTitle)
            Button(action: addTodo) {
                Text("Add")
            }
        }
        .padding()
        .navigationTitle("Todo Details")
    }
    
    private func addTodo() {
        todos.append(Todo(title: todoTitle, status: .pending))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
