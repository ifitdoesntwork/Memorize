//
//  ThemedArrayElement.swift
//  Memorize
//
//  Created by Denis Avdeev on 06.12.2024.
//

import Foundation

protocol ThemedArrayElement {
    associatedtype Theme: Equatable, Identifiable
    
    init(theme: Theme)
    var theme: Theme { get }
    func updateTheme(to theme: Theme)
}

extension Array
where Element: ThemedArrayElement {
    
    var themes: [Element.Theme] {
        get {
            map(\.theme)
        }
        set {
            let diff = newValue
                .difference(from: themes)
            
            if let (index, _, updatedTheme) = diff.onlyElementUpdate {
                self[index]
                    .updateTheme(to: updatedTheme)
            } else {
                diff
                    .forEach {
                        switch $0 {
                        case .insert(let offset, let theme, _):
                            insert(.init(theme: theme), at: offset)
                        case .remove(let offset, _, _):
                            remove(at: offset)
                        }
                    }
            }
        }
    }
}

private extension CollectionDifference
where ChangeElement: Identifiable {
    
    var onlyElementUpdate: (
        index: Int,
        oldValue: ChangeElement,
        newValue: ChangeElement
    )? {
        if
            case .insert(let insertionIndex, let insertedElement, _) = insertions.only,
            case .remove(let removalIndex, let removedElement, _) = removals.only,
            insertionIndex == removalIndex,
            insertedElement.id == removedElement.id
        {
            return (insertionIndex, removedElement, insertedElement)
        }
        return nil
    }
}
